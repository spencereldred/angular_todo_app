app = angular.module("Todos", ["ngResource"])

app.factory "Todos", ($resource) ->
  $resource("/todos/:id.json", {id: "@id"}, {update: {method: "PUT"}})

@TodoCtrl = ($scope, Todos) ->
  $scope.todos = Todos.query()

  $scope.addTodo = ->
    $scope.newTodo.done = false
    todo = Todos.save($scope.newTodo)
    #todo.done = false
    # console.log todo
    # debugger
    #todo.$update()
    $scope.todos.push(todo)
    $scope.newTodo = {}

  $scope.checkbox = ->
    console.log "Checkbox clicked"
    console.log $scope.checkbox.todo
    # debugger
    # $scope.newTodo.done = true
