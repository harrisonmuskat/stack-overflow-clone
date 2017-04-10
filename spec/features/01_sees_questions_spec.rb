require 'rails_helper'
require 'pry'

feature "sees questions" do
  user = User.create!(provider: 'test', uid: '1203214982', first_name: 'Dan', last_name: 'Pickett', username: 'dpickett')
  let!(:question1) { Question.create(title: "Rails is hard aisjodoaijASDIJOAOISJDOIAWJEOIWAEweoaiwheo", description: "How do I write routes alsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkawlsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkaw?", user: user) }
  let!(:question2) { Question.create(title: "Testing testing 123 aopksdpASPDOKAPOWKEPAOWKDPAWOKDPOWKAoakwepokawpeokwpaOKDPOAW", description: "How do I set up FactoryGirl alsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkawlsjdpaijwepoakwepoakdpwokwapeokpawokepaodkpawokedpawokeipoawkdpawoekpaokwdfpokapofkaw?", user: user) }

  scenario "see all the questions" do
    visit questions_path
    expect(page).to have_content(question1.title)
    expect(page).to have_content(question2.title)
  end

  scenario "sees the questions in reverse chronological order" do
    visit questions_path
    expect page.body.index(question2.title) < page.body.index(question1.title)
  end
end
