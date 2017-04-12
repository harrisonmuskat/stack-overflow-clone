require 'pry'

class AnswersController < ApplicationController
  def index
    @question = Question.find(params[:question_id])
    @answers = @question.answers.order(best: :desc, created_at: :desc)
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = Answer.new(answer_params)
    @answer.question = @question

    if @answer.save
      flash[:success] = "Answer saved correctly."
      redirect_to question_answers_path(@question)
    else
      flash[:alert] = @answer.errors.full_messages.to_sentence
      redirect_to question_answers_path(@question)
    end

  end
  #
  # def edit
  #   @answer = Answer.find(params[:id])
  # end

  def update
    @answer = Answer.find(params[:id])

    @question = @answer.question
    @question.answers.each do |test_answer|
      test_answer.best = false
      test_answer.save
    end
    @answer.best = true

    if @answer.save
      flash[:success] = "Answer marked as best answer."
      redirect_to question_answers_path(@answer.question)
    else
      flash[:alert] = "There was an error."
      redirect_to question_answers_path(@answer.question)
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:description)
  end
end
