defmodule BinTree do
  @moduledoc """
  A node in a binary tree.

  `value` is the value of a node.
  `left` is the left subtree (nil if no subtree).
  `right` is the right subtree (nil if no subtree).
  """
  @type t :: %BinTree{value: any, left: BinTree.t() | nil, right: BinTree.t() | nil}
  defstruct value: nil, left: nil, right: nil
end

defmodule Zipper do
  @moduledoc """
  A bintree with zipper

  `focus` is the bintree node in focus.
  `trail` is a list of bintree nodes traversed to get to the focus.

  Also has functions to manipulate a Zipper.
  Combine a BinTree with a zipper using `from_tree`, and get the tree back with `to_tree`.
  Move `left`, `right` and `up`.
  Get the `value`, or set it with `set_value`.
  Manipulate left and right nodes with `set_left` and `set_right`.
  """

  @type trail :: [{:left, any, BinTree.t()} | {:right, any, BinTree.t()}]
  @type t :: %Zipper{focus: BinTree.t(), trail: trail}

  defstruct focus: nil, trail: []

  alias Zipper, as: Z
  alias BinTree, as: BT

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BT.t()) :: Z.t()
  def from_tree(bt), do: %Z{focus: bt}

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Z.t()) :: BT.t()
  def to_tree(z = %Z{trail: []}), do: z.focus
  def to_tree(z), do: z |> up |> to_tree

  @doc """
  Get the value of the focus node.
  """
  @spec value(Z.t()) :: any
  def value(z), do: z.focus.value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Z.t()) :: Z.t() | nil
  def left(%Z{focus: %BT{left: nil}}), do: nil

  def left(%Z{focus: bt, trail: trail}) do
    %Z{
      focus: bt.left,
      trail: [{:left, bt.value, bt.right} | trail]
    }
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Z.t()) :: Z.t() | nil
  def right(%Z{focus: %BT{right: nil}}), do: nil

  def right(%Z{focus: bt, trail: trail}) do
    %Z{
      focus: bt.right,
      trail: [{:right, bt.value, bt.left} | trail]
    }
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Z.t()) :: Z.t()
  def up(%Z{trail: []}), do: nil

  def up(%Z{focus: left, trail: [{:left, value, right} | trail]}) do
    %Z{focus: %BT{value: value, left: left, right: right}, trail: trail}
  end

  def up(%Z{focus: right, trail: [{:right, value, left} | trail]}) do
    %Z{focus: %BT{value: value, left: left, right: right}, trail: trail}
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Z.t(), any) :: Z.t()
  def set_value(z, v), do: %Z{z | focus: %BT{z.focus | value: v}}

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Z.t(), BT.t()) :: Z.t()
  def set_left(z, l), do: %Z{z | focus: %BT{z.focus | left: l}}

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Z.t(), BT.t()) :: Z.t()
  def set_right(z, r), do: %Z{z | focus: %BT{z.focus | right: r}}
end
