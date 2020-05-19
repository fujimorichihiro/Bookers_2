class SearchController < ApplicationController

	def search
      @table = params[:table]
      option = params[:option]
      if @table == "1"
        @users = User.search(params[:search], @table, option)
      else
        @books = Book.search(params[:search], @table, option)
      end
    end
end
