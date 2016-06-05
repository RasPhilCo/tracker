class ListTasks < ListCollection

  attr_defaultable :result_serializer, -> { V1::TaskSerializer }

  def initialize(parent, **opts)
    @parent = parent
    super(opts)
  end

  def collection_type
    :tasks
  end

  def collection
    @tasks ||= @parent.tasks
  end
end
