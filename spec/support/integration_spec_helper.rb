module IntegrationSpecHelper
  def login_with_oauth(service = :linkedin)
    visit "/auth/#{service}"
  end
end
