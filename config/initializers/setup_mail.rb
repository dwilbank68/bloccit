if Rails.env.development?
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
      address:        'smtp.sendgrid.net',
      port:           '587',
      authentication: :plain,
      user_name:      ENV['app29446464@heroku.com'],
      password:       ENV['pibk1ecm'],
      domain:         'heroku.com',
      enable_starttls_auto: true
  }

end