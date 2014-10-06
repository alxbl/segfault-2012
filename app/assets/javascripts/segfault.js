function CommentCtrl($scope) {
  $scope.comments = [];
  
  $scope.addComment = function() {
    $scope.comments.push({author: $scope.author, body: $scope.body, flagged: false});
  }
}