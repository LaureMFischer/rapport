class ConnectionsController <ApplicationController
  def index
    new_user = LinkedIn::Client.new("773hhhekczsv49", "vT2ay9SKyzFEQ0mh")
    new_user.authorize_from_access("101bd476-d4bc-4e82-a1cb-cea03e3b93f2", "3f02a55b-39de-4e89-9be4-11fac34233a4")
    @connections = new_user.connections.all
  end
end
