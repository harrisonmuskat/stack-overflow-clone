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
      flash[:success] = "Question saved successfully."
      redirect_to @question
    else
      flash[:alert] = @question.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])

    if @question.update(question_params)
      flash[:success] = "Question saved successfully."
      redirect_to @question
    else
      flash[:alert] = @question.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    # @question = Question.find(params[:id])
    Question.where(id: params[:id]).destroy_all
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :description, :user_id)
  end
end
