class DswSchema < GraphQL::Schema
  use GraphQL::Tracing::NewRelicTracing
  mutation Types::MutationType
  query Types::QueryType
end
