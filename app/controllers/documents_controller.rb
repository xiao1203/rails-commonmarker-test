class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :edit, :update, :destroy]

  def index
    @documents = Document.order(id: :desc)
  end

  def show
  end

  def new
    @document = Document.new
  end

  def edit
  end

  def create
    @document = Document.new(document_params)

    if params[:preview_button]
      @document.assign_html
      render :new
    elsif @document.save
      redirect_to @document, notice: 'Document was successfully created.'
    else
      render :new
    end
  end

  def update
    if params[:preview_button]
      @document.assign_attributes(document_params)
      @document.assign_html
      render :edit
    elsif @document.update(document_params)
      redirect_to @document, notice: 'Document was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @document.destroy
    redirect_to documents_url, notice: 'Document was successfully destroyed.'
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.fetch(:document, {}).permit(:title, :markdown)
  end
end
