class TicketPolicy < ApplicationPolicy
  # NOTE: Up to Pundit v2.3.1, the inheritance was declared as
  # `Scope < Scope` rather than `Scope < ApplicationPolicy::Scope`.
  # In most cases the behavior will be identical, but if updating existing
  # code, beware of possible changes to the ancestors:
  # https://gist.github.com/Burgestrand/4b4bc22f31c8a95c425fc0e30d7ef1f5

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    console
    true
  end

  def update?
    true
  end

  def bulk_new?
    true
  end

  def bulk_create?
    user&.role == "promoter"
  end

  def my_listings?
    true
  end

  def my_tickets?
    true
  end

  def cart?
    true
  end

  def cancel?
    true
  end

  def mark_as_pending?
    true
  end

  def mark_as_sold?
    true
  end

  def mark_as_for_sale?
    true
  end

  def stop?
    true
  end

  def show?
    true
  end
end
