require_relative "./_configure"

DB.define_table("users")
DB.define_column("users", "name", "string")
DB.define_column("users", "email", "string")
DB.define_column("users", "password", "string")
DB.define_column("users", "created_by", "integer")
DB.define_column("users", "updated_by", "integer")

DB.define_table("todos")
DB.define_column("todos", "title", "string")
DB.define_column("todos", "description", "text")
DB.define_column("todos", "completed", "boolean")
DB.define_column("todos", "user_id", "integer")
DB.define_column("todos", "created_by", "integer")
DB.define_column("todos", "updated_by", "integer")

DB.define_table("lists")
DB.define_column("lists", "title", "string")
DB.define_column("lists", "user_id", "integer")
DB.define_column("lists", "todo_id", "integer")
DB.define_column("lists", "completed", "boolean")
DB.define_column("lists", "created_by", "integer")
DB.define_column("lists", "updated_by", "integer")