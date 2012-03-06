require "spec_helper"

describe Notifier do
  describe "survey_inviter" do
    let(:mail) { Notifier.survey_inviter }

    it "renders the headers" do
      mail.subject.should eq("Survey inviter")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
