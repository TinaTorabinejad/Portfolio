
from games import *

class GameOfNim(Game):
    # YOUR CODE GOES HERE
    # raise NotImplementedError
    def __init__(self, board):
        moves = [(x, y) for x in range(0, len(board))
                 for y in range(1, board[x]+1)]
        self.initial = GameState(to_move='MAX', utility=0, board=board, moves=moves)

    def result(self, state, move):
        board = state.board.copy()
        board[move[0]] -= move[1]
        moves = [(x, y) for x in range(0, len(board))
                 for y in range(1, board[x]+1)]
        player = state.to_move
        return GameState(to_move=("MIN" if state.to_move == "MAX" else "MAX"),
                         utility=self.compute_utility(moves, player),
                         board=board, moves=moves)
    
    def actions(self, state):
        moves = [(x, y) for x in range(0, len(state.board))
                 for y in range(1, state.board[x]+1)]
        return moves
    
    def terminal_test(self, state):
        return state.utility != 0 or len(state.moves) == 0
    
    def utility(self, state, player):
        return state.utility if player == 'MAX' else -state.utility
    
    def compute_utility(self, moves, player):
        """If 'MAX' wins with this move, return 1; if 'MIN' wins return -1; else return 0."""
        if (len(moves) == 0):
            return +1 if player == 'MAX' else -1
        else:
            return 0

    def to_move(self, state):
        return super().to_move(state)
    
    def display(self, state):
        # board = state.board
        print("board: ", state.board)


if __name__ == "__main__":
    nim = GameOfNim(board=[0, 5, 3, 1])  # Creating the game instance
    #nim = GameOfNim(board=[7, 5, 3, 1]) # a much larger tree to search
    print(nim.initial.board) # must be [0, 5, 3, 1]
    print(nim.initial.moves) # must be [(1, 1), (1, 2), (1, 3), (1, 4), (1, 5), (2, 1), (2, 2), (2, 3), (3, 1)]
    # print(nim.to_move(nim.initial))
    print(nim.result(nim.initial, (1,3) ))
    utility = nim.play_game(alpha_beta_player, query_player) # computer moves first 
    if (utility < 0):
        print("MIN won the game")
    else:
        print("MAX won the game")