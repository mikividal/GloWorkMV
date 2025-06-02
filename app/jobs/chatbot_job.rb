class ChatbotJob < ApplicationJob
  queue_as :default

  def perform(question)
    @question = question
    chatgpt_response = client.chat(
      parameters: {
        model: "gpt-4o-mini",
        messages: questions_formatted_for_openai # to code as private method
      }
    )
    new_content = chatgpt_response["choices"][0]["message"]["content"]

    question.update(ai_answer: new_content)
    Turbo::StreamsChannel.broadcast_update_to(
      "question_#{@question.id}",
      target: "question_#{@question.id}",
      partial: "questions/question", locals: { question: question })
  end

  private

  def client
    @client ||= OpenAI::Client.new
  end

  def questions_formatted_for_openai
    questions = @question.user.questions
    results = []
    results << { role: "system", content: "You are a friendly and professional assistant helping remote workers improve their mood and well-being at work.

    Start the conversation by saying: “Hello, how can I help you today?”

    When the user shares something, respond with 2-3 concise and practical tips they can try. The tips should be focused, actionable, and easy to follow — avoid vague or generic advice.

    Do not continue the conversation or ask more questions, such as 'Is there anything else I can help you with?'.

    Keep responses supportive and brief. Do not give medical or therapeutic advice." }
    questions.each do |question|
      results << { role: "user", content: question.user_question }
      results << { role: "assistant", content: question.ai_answer || "" }
    end
    return results
  end

end
