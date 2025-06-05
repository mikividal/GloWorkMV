Warden::Manager.after_authentication do |user, auth, opts|
  auth.flash[:show_welcome_modal] = true
end
