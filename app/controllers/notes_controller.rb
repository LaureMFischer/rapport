class NotesController < ApplicationController
  before_action :get_connection
  def index
    @notes = @connection.notes.order(:created_at)
  end

  def show

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
end
