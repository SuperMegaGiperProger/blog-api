# frozen_string_literal: true

if Rails.env.development?
  require 'annotate'
  task :set_annotation_options do
    Annotate.set_defaults(
      'position_in_routes' => 'after',
      'position_in_class' => 'after',
      'position_in_test' => 'before',
      'position_in_fixture' => 'after',
      'position_in_factory' => 'after',
      'show_indexes' => 'true',
      'simple_indexes' => 'false',
      'model_dir' => 'app/models',
      'include_version' => 'false',
      'require' => '',
      'exclude_tests' => 'false',
      'exclude_fixtures' => 'false',
      'exclude_factories' => 'false',
      'ignore_model_sub_dir' => 'false',
      'skip_on_db_migrate' => 'false',
      'format_bare' => 'true',
      'format_rdoc' => 'false',
      'format_markdown' => 'false',
      'sort' => 'false',
      'force' => 'false',
      'trace' => 'false'
    )
  end

  Annotate.load_tasks
end
