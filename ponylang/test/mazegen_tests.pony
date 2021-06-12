
use "../mazegen"
use "ponytest"
use "random"


class FixedListRandom is Random
        let arr: Array[U64] val
        var location: USize = 0
        new create(x: U64, y: U64) =>
                arr = recover val [] end
        new fixed(arr': Array[U64] val) =>
                arr = arr'
        fun ref next(): U64 =>
                let v = try arr(location)? else 0 end
                location = location + 1
                v



primitive _MazeGenTest is TestWrapped
    fun all_tests(): Array[UnitTest iso] =>
        [as UnitTest iso:

object iso is UnitTest
    fun name(): String => "maze / create / 1x1 / width"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(1, 1)
        h.assert_eq[USize](1, undertest.width)
end
object iso is UnitTest
    fun name(): String => "maze / create / 1x1 / height"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(1, 1)
        h.assert_eq[USize](1, undertest.height)
end
object iso is UnitTest
    fun name(): String => "maze / render / 1x1"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(1, 1)
        h.assert_eq[String]("*-*\n| |\n*-*", undertest.render())
end
object iso is UnitTest
    fun name(): String => "maze / render / 2x1"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(2, 1)
        h.assert_eq[String]("*-*-*\n| | |\n*-*-*", undertest.render())
end
object iso is UnitTest
    fun name(): String => "maze / render / 1x2"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(1, 2)
        h.assert_eq[String](
            "*-*\n"+
            "| |\n"+
            "*-*\n"+
            "| |\n"+
            "*-*",
            undertest.render())
end
object iso is UnitTest
    fun name(): String => "maze / generate / 1x2 / 0,0"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(1, 2)
        let rand: Random = FixedListRandom.fixed(recover val [as U64: 0] end)
        undertest.generate(0, 0, rand)
        h.assert_eq[Cell](Cell.create(true, true, true), try undertest.cell(0, 0)? else Cell end)
        h.assert_eq[Cell](Cell.create(false, true, true), try undertest.cell(0, 1)? else Cell end)
end
object iso is UnitTest
    fun name(): String => "maze / generate / 2x1 / 1,0"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(2, 1)
        let rand: Random = FixedListRandom.fixed(recover val [as U64: 0] end)
        undertest.generate(1, 0, rand)
        h.assert_eq[Cell](Cell.create(true, true, true), try undertest.cell(0, 0)? else Cell end)
        h.assert_eq[Cell](Cell.create(true, false, true), try undertest.cell(1, 0)? else Cell end)
end
object iso is UnitTest
    fun name(): String => "maze / cell / 1x1 / 0,0"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(1, 1)
        h.assert_eq[Bool](true, try undertest.cell(0,0)?.wall_up else false end)
        h.assert_eq[Bool](true, try undertest.cell(0,0)?.wall_left else false end)
end
object iso is UnitTest
    fun name(): String => "maze / options from / 1x1 / 0,0"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(1, 1)
        let result = undertest.options_from(0, 0)
        h.assert_eq[USize](0, result.size())
end
object iso is UnitTest
    fun name(): String => "maze / options from / 1x2 / 0,0"
    fun apply(h: TestHelper) =>
        let undertest: Maze = Maze.create(1, 2)
        let result = undertest.options_from(0, 0)
        h.assert_eq[USize](1, result.size())
        h.assert_is[(Direction| None)](Down, try result(0)? end)
end

object iso is UnitTest
    fun name(): String => "direction / up / update cells"
    fun apply(h: TestHelper) =>
        let result = Up.update_cells(
                Cell.create(true, true, false),
                Cell.create(true, true, false)
        )
        h.assert_eq[Cell](Cell.create(false, true, true), result._1)
        h.assert_eq[Cell](Cell.create(true, true, true), result._2)
end
object iso is UnitTest
    fun name(): String => "direction / up / can_move / no"
    fun apply(h: TestHelper) =>
        h.assert_eq[Bool](false, Up.can_move(9, 0, 10, 10))
end
object iso is UnitTest
    fun name(): String => "direction / up / can_move / yes"
    fun apply(h: TestHelper) =>
        h.assert_eq[Bool](true, Up.can_move(9, 1, 10, 10))
end
object iso is UnitTest
    fun name(): String => "direction / up / move"
    fun apply(h: TestHelper) =>
        h.assert_eq[USize](9, Up.move(9, 5)._1)
        h.assert_eq[USize](4, Up.move(9, 5)._2)
end

object iso is UnitTest
    fun name(): String => "direction / down / update cells"
    fun apply(h: TestHelper) =>
        let result = Down.update_cells(
                Cell.create(true, true, false),
                Cell.create(true, true, false)
        )
        h.assert_eq[Cell](Cell.create(true, true, true), result._1)
        h.assert_eq[Cell](Cell.create(false, true, true), result._2)
end
object iso is UnitTest
    fun name(): String => "direction / down / can_move / no"
    fun apply(h: TestHelper) =>
        h.assert_eq[Bool](false, Down.can_move(9, 9, 10, 10))
end
object iso is UnitTest
    fun name(): String => "direction / down / can_move / yes"
    fun apply(h: TestHelper) =>
        h.assert_eq[Bool](true, Down.can_move(9, 1, 10, 10))
end
object iso is UnitTest
    fun name(): String => "direction / down / move"
    fun apply(h: TestHelper) =>
        h.assert_eq[USize](9, Down.move(9, 5)._1)
        h.assert_eq[USize](6, Down.move(9, 5)._2)
end

object iso is UnitTest
    fun name(): String => "direction / left / update cells"
    fun apply(h: TestHelper) =>
        let result = Left.update_cells(
                Cell.create(true, true, false),
                Cell.create(true, true, false)
        )
        h.assert_eq[Cell](Cell.create(true, false, true), result._1)
        h.assert_eq[Cell](Cell.create(true, true, true), result._2)
end
object iso is UnitTest
    fun name(): String => "direction / left / can_move / no"
    fun apply(h: TestHelper) =>
        h.assert_eq[Bool](false, Left.can_move(0, 9, 10, 10))
end
object iso is UnitTest
    fun name(): String => "direction / left / can_move / yes"
    fun apply(h: TestHelper) =>
        h.assert_eq[Bool](true, Left.can_move(9, 1, 10, 10))
end
object iso is UnitTest
    fun name(): String => "direction / left / move"
    fun apply(h: TestHelper) =>
        h.assert_eq[USize](8, Left.move(9, 5)._1)
        h.assert_eq[USize](5, Left.move(9, 5)._2)
end

object iso is UnitTest
    fun name(): String => "direction / right / update cells"
    fun apply(h: TestHelper) =>
        let result = Right.update_cells(
                Cell.create(true, true, false),
                Cell.create(true, true, false)
        )
        h.assert_eq[Cell](Cell.create(true, true, true), result._1)
        h.assert_eq[Cell](Cell.create(true, false, true), result._2)
end
object iso is UnitTest
    fun name(): String => "direction / right / can_move / no"
    fun apply(h: TestHelper) =>
        h.assert_eq[Bool](false, Right.can_move(9, 9, 10, 10))
end
object iso is UnitTest
    fun name(): String => "direction / right / can_move / yes"
    fun apply(h: TestHelper) =>
        h.assert_eq[Bool](true, Right.can_move(5, 1, 10, 10))
end
object iso is UnitTest
    fun name(): String => "direction / right / move"
    fun apply(h: TestHelper) =>
        h.assert_eq[USize](10, Right.move(9, 5)._1)
        h.assert_eq[USize](5, Right.move(9, 5)._2)
end
]
