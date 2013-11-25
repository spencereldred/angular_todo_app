app = angular.module("Todos", ["ngResource"])

app.factory "Todos", ($resource) ->
  $resource("/todos/:id.json", {id: "@id"}, {update: {method: "PUT"}})

@TodoCtrl = ($scope, Todos) ->
  $scope.todos = Todos.query()

  $scope.addTodo = ->
    $scope.newTodo.done = false
    todo = Todos.save($scope.newTodo)
    $scope.todos.push(todo)
    $scope.newTodo = {}

  $scope.checkbox = ->
    todo = @todo
    todo.$update()
    console.log $scope
