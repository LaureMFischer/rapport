class ConnectionsController <ApplicationController
  before_action :get_user

  def index
    @connections = @user.connections.order(:last_name)
    @connection = Connection.new
    new_user = LinkedIn::Client.new(ENV["APP_ID"], ENV["APP_SECRET"])
    new_user.authorize_from_access(@user.token, @user.secret)
    @linkedin_profile = new_user.profile
    @linkedin_connections = new_user.connections.all
  end

  def new
    @connection = Connection.new
  end

  def create
    new_user = LinkedIn::Client.new(ENV["APP_ID"], ENV["APP_SECRET"])
    new_user.authorize_from_access(@user.token, @user.secret)
    @linkedin_connections = new_user.connections.all
      if @linkedin_connections.nil? == false
        @linkedin_connections.each do |linkedin_connection|
          if linkedin_connection["first_name"] != "private"
            @user.connections << Connection.find_or_create_by(first_name: linkedin_connection["first_name"], last_name: linkedin_connection["last_name"], headline: linkedin_connection["headline"], linkedin_id: linkedin_connection["id"], user_id: @user.id)
          else
          end
        end
      else
      end
    redirect_to connections_path
  end

  def edit
    @connection = Connection.find(params[:id])
  end

  def update
    @connection = Connection.find(params[:id])
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
    @connection = Connection.find(params[:id])
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

  def get_user
    @user = current_user
  end
end
