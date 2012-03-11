class Notifier < ActionMailer::Base
  default from: "iSurvey@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notifier.survey_inviter.subject
  #
  def survey_inviter(survey, user)
    @survey = survey
   
    mail to: user.email, subject: 'You have a new survey.'
  end
end
