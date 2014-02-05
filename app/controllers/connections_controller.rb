class ConnectionsController <ApplicationController
  before_action :get_user

  def index
    @connections = Connection.order(:date)
    new_user = LinkedIn::Client.new(ENV["APP_ID"], ENV["APP_SECRET"])
    new_user.authorize_from_access(@user.token, @user.secret)
    @linkedin_profile = new_user.profile
  end

  def show
    @connection = Connection.find(params[:id])
  end

  def new
    @connection = Connection.new
    new_user = LinkedIn::Client.new(ENV["APP_ID"], ENV["APP_SECRET"])
    new_user.authorize_from_access(@user.token, @user.secret)
    @linkedin_connections = new_user.connections.all
  end

  def create
    @user.connections << Connection.create(connection_params)
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
      redirect_to @connection
    else
      flash.now[:errors] = @connection.errors.full_messages
      render :edit
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
