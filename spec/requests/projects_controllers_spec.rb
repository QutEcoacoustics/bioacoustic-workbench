require 'spec_helper'
require 'csv'

projects_controllers_path = "/projects"

describe "ProjectsControllers" do

  # THIS IS THE BASE RULE - IT IS NOT IN THE DATABASE
  #it 'should ensure that if no permission records match, the request is denied'
  #
  #it 'when a user is logged in, should ensure the database has a permission record where the permissionable object is null, the user is null, and the level is read or none'
  #
  #
  #it 'should *allow* a *GET#show* request for a *project* given a user is *logged in* and the *known* user has *owner* permissions on the *project*'
  #it 'should *deny* a *GET#show* request for a *project* given a user is *logged in* and the *known* user has *none* permissions on the *project*'
  #
  #it 'should *deny* a *GET#show* request by *an anonymous* user for a *project* given a user is *not logged in* and the *anonymous* user has *none* permissions on the *project*'
  #it 'should *allow* a *GET#show* request by *an anonymous* user for a *project* provided a permission record a user is *not* specified and has *read* permissions'
  #
  #it 'should *deny* a *GET#show* request by *a known* user for a *site* provided a permission record *is not present* '


  context "permission combinations" do
    csv_text = File.read('./spec/requests/request_truth_table.csv')
    csv = CSV.parse(csv_text, :headers => false)
    #csv.each do |row|
      #row = row.to_hash.with_indifferent_access
      #Moulding.create!(row.to_hash.symbolize_keys)
    #end

    cases = [{}, {}]

    #cases.each { |test_case|
    #  it "should be #{'not' unless test_case[:valid]} valid when user is #{'not' unless test_case[:id]} present and user is #{'not' unless test_case[:logged_in]} logged in and permission level is '#{test_case[:level]}'" do
    #    u = nil
    #    u = create(:user) if test_case[:id]
    #    p = build(:permission, {level: test_case[:level], user: u, logged_in: test_case[:logged_in]})
    #    if test_case[:valid]
    #      p.should be_valid
    #    else
    #      p.should_not be_valid
    #    end
    #  end
    #}
  end
end
