class LanguagesController < ApplicationController
   #needs to be accessible to posts & USERS?????????
   def create
    @language = Language.new
    @language.save #need to check this method but this is where we need to redirect to next page
      redirect_to @input
    end

  def index
    @language = Language.all.order('created_at DESC') #incase we want to show them in an index
  end

 
  
  def show
    @language = Language.find(:id) 
  end

  
end
