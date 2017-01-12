module ActiveAdmin
  class CommentPolicy < ApplicationPolicy
    def index?
      true
    end
  end
end
