class NotesController < ApplicationController
  before_action :get_connection
  before_action :new_linkedin_client, only: [:index, :edit, :new]
  before_action :get_profile, only: [:index, :new, :edit]

  def index
    @notes = @connection.notes.order(:created_at)
  end

  def new
    @note = Note.new
  end

  def create
    @connection.notes << Note.create(note_params)
    redirect_to connection_notes_path(@connection.id)
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    @note.assign_attributes(note_params)

    if @note.save
      flash[:notice] = 'Updated the note!'
      redirect_to connection_notes_path(@connection.id)
    else
      flash.now[:errors] = @note.errors.full_messages
      render :edit
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :date_of_interaction, :connection_id)
  end

  def get_connection
    @connection = Connection.find(params[:connection_id])
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
