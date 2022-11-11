class BooksController < ApplicationController
  def index
    #Bookからallメソッドを呼び出すことで、Bookテーブル内に保存されているすべてのデータを取得できる。
    @books = Book.all

    #新規投稿機能で使うインスタンス変数に空のModelオブジェクトを作成する。
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :index
    end

    flash[ :notice] = "Book was successfully created."
    redirect_to "/books/:id"
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if @book.save
      redirect_to book_path(@book.id)
    else
      render :edit
    end

    book.update(book_params)
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end