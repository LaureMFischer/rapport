class ConnectionsController <ApplicationController
  before_action :get_connection, only: [:edit, :update, :destroy]
  before_action :new_linkedin_client, only: [:index, :create, :edit]
  before_action :get_profile, only: [:index, :edit]

  def index
    @connections = current_user.connections.order(:last_name)
    @connection = Connection.new
  end

  def new
    @connection = Connection.new
  end

  def create
    if @linkedin_connections.nil? == false
      @linkedin_connections.each do |linkedin_connection|
        if linkedin_connection["first_name"] != "private"
          current_user.connections << Connection.find_or_create_by(first_name: linkedin_connection["first_name"], last_name: linkedin_connection["last_name"], headline: linkedin_connection["headline"], linkedin_id: linkedin_connection["id"], user_id: current_user.id)
        else
        end
      end
    else
    end
    redirect_to connections_path
  end

  def edit
  end

  def update
    @connection.assign_attributes(connection_params)

    if @connection.save
      flash[:notice] = 'Updated the connection!'
      redirect_to connection_notes_path(@connection.id)
    else
      flash.now[:errors] = @connection.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @connection.destroy
      flash[:notice] = 'Deleted the connection!'
      redirect_to connections_path
    else
      flash.now[:errors] = @connection.errors.full_messages
      redirect_to :back
    end
  end

  private

  def connection_params
    params.require(:connection).permit(:first_name, :last_name, :headline, :date, :user_id)
  end

  def get_connection
    @connection = Connection.find(params[:id])
  end

  def new_linkedin_client
    @new_user = LinkedIn::Client.new(ENV["APP_ID"], ENV["APP_SECRET"])
    @new_user.authorize_from_access(current_user.token, current_user.secret)
    @linkedin_connections = @new_user.connections.all
  end

  def get_profile
    @linkedin_profile = @new_user.profile
  end
end
