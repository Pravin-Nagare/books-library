class BooksController < ApplicationController
  # GET /books
  # GET /books.json
  def index
    @books = Book.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @books }
    end
  end

  # GET /books/1
  # GET /books/1.json
  def show
    @book = Book.find(params[:id])
    detail=Openlibrary::Data
    @details = detail.find_by_isbn(@book.isbn)
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/new
  # GET /books/new.json
  def new
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @book }
    end
  end

  # GET /books/1/edit
  def edit
    @book = Book.find(params[:id])
    @user = User.find_by_email(session["email"])
    begin
    	@user.books << @book 
    rescue Exception=>e
    	puts e.message
    end
    @faved=@user.books
    user=[];
    @faved.each do |j|
    	users=j.users
    	users.each do |i|
    	   user[i.id]=user[i.id].to_i + 1 if(i.id!=@user.id)
    	   
    	   puts "-------------------------------------->","user id #{i.id}   :   #{ user[i.id]}   :    #{i.email} "
    	end
    end
    user=user.map{|i| i=0 if i==nil; i=i if i!=nil}
    @liked=[]
    while true
    
    	max_index=user.index(user.max)
    	break if user.max==0 or user.max==nil
    	@user2=User.find(max_index)
    	
    	@user2.books.each do |i|
    		puts "-----------------------------------------",@user2.email
    		if((@user.books.include? i) == false and (@liked.include? i) == false)
    			@liked.push i.clone
    		end
    				
    		return if @liked.length==10
    	end
    	user[max_index]=0
    
    end
    
    
  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(params[:book])

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render json: @book, status: :created, location: @book }
      else
        format.html { render action: "new" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
      
    end
  end

  # PUT /books/1
  # PUT /books/1.json
  def update
    @book = Book.find(params[:id])

    respond_to do |format|
      if @book.update_attributes(params[:book])
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url }
      format.json { head :no_content }
    end
  end
end
