require 'pry'

class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answers = Answer.where(question: @question).order(created_at: :desc)
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)

    if @question.save
      redirect_to @question
    else
      render action: 'new'
    end
  end

  private

  def question_params
    params.require(:question).permit(:title, :description, :user_id)
  end
end
