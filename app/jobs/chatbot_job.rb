class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question_id)  # Cambiado: recibe question_id, no question
    puts "=== DEBUG CHATBOT JOB ==="
    puts "OPENAI_ACCESS_TOKEN presente: #{ENV['OPENAI_ACCESS_TOKEN']&.present?}"
    puts "Primeros 10 caracteres: #{ENV['OPENAI_ACCESS_TOKEN']&.first(10)}"
    puts "Question ID: #{question_id}"
    puts "========================="

    begin
      # Busca la question por ID
      @question = Question.find(question_id)
      puts "Question encontrada: #{@question.id}"

      puts "Llamando a OpenAI..."
      chatgpt_response = client.chat(
        parameters: {
          model: "gpt-4o-mini",
          messages: questions_formatted_for_openai
        }
      )
      puts "Respuesta de OpenAI recibida"

      new_content = chatgpt_response["choices"][0]["message"]["content"]
      puts "Contenido extraído: #{new_content[0..50]}..."

      @question.update(ai_answer: new_content)
      puts "Question actualizada"

      Turbo::StreamsChannel.broadcast_update_to(
        "question_#{@question.id}",
        target: "question_#{@question.id}",
        partial: "questions/question",
        locals: { question: @question }
      )
      puts "Broadcast enviado"
      puts "Job completado exitosamente!"

    rescue => e
      puts "ERROR EN CHATBOT JOB: #{e.class}: #{e.message}"
      puts "Backtrace: #{e.backtrace.first(5)}"
      raise e
    end
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []
    results << {
      role: "system",
      content: "You are a friendly and professional assistant helping remote workers improve their mood and well-being at work.

      Start the conversation by saying: \"Hello, how can I help you today?\"

      When the user shares something, engage in conversation and be empathic. If you give tips, they should be focused, actionable, and easy to follow — avoid vague or generic advice.

      ask follow up questions. If the user says things like 'thank you' or any other phrase suggesting the end of the conversation, then politely end the conversation.

      Keep responses supportive and brief. Do not give medical or therapeutic advice."
    }

    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end

    return results
  end
end
