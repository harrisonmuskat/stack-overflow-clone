require 'pry'

class AnswersController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers
  end
#
  def new
    @question = Question.find(params[:question_id])
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question
    if @answer.save
      flash[:notice] = "Answer saved correctly."
      redirect_to question_path(@question)
    else
      flash[:notice] = @answer.errors.full_messages.to_sentence
      redirect_to question_path(@question)
    end



  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end
end
