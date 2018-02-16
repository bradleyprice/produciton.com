require 'rails_helper'

RSpec.describe ShareChecklistMailer, type: :mailer do
  describe 'email' do
    let(:from_user) { double('User', id: 1, email: 'from@example.com') }
    let(:to_user) { double('User', id: 2, email: 'to@example.org') }
    let(:checklist) { double('Checklist', id: 1) }
    let(:mail) { ShareChecklistMailer.email(from_user.id, to_user.id, checklist.id) }

    before do
      allow(User).to receive(:find).with(from_user.id).and_return(from_user)
      allow(User).to receive(:find).with(to_user.id).and_return(to_user)
      allow(Checklist).to receive(:find).with(checklist.id).and_return(checklist)
    end

    it 'renders the headers' do
      expect(mail.subject).to eq("#{from_user.email} has shared a Checklist with you!")
      expect(mail.to).to eq(['to@example.org'])
      expect(mail.from).to eq([Rails.application.secrets.produciton_email].compact)
    end

    it 'renders the body' do
      expect(mail.body.encoded).to include('Howdy')
    end
  end
end
