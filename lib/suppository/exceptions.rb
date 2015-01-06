class UsageError < RuntimeError
end

class InvalidDistribution < RuntimeError
end

class InvalidComponent < RuntimeError
end

class MissingDependencyError < RuntimeError
end

class InvalidMasterDeb < RuntimeError
end

class InvalidRepositoryError < RuntimeError
end
