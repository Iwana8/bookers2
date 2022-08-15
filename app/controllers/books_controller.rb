class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def index
    @books =Book.all
    @user = current_user
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
  end

  def create
    @book =  Book.new(books_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to books_path
    else
      @books =Book.all
      @user = current_user
      render :index
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(books_params)
    flash[:notice] = "You have updated successfully."
    redirect_to book_path(@book.id)
    else
    render :edit
    end
  end

    def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
    end

   private

   def books_params
     params.require(:book).permit(:title, :body, :profile_image)
   end
end
