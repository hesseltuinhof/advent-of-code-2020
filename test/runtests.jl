using AdventOfCode, Test

@testset "day01" begin
    seq = [1721, 979, 366, 299, 675, 1456]
    @test AdventOfCode.find_two_entries(seq) == 1721 * 299
    @test AdventOfCode.find_three_entries(seq) == 979 * 366 * 675
    @test day01() == (1010299, 42140160)
end

@testset "day02" begin
    policies = (["1-3 a", "1-3 b", "2-9 c", "3-7 g"])
    policies_sled = AdventOfCode.PasswordPolicySled.(policies)
    policies_toboggan = AdventOfCode.PasswordPolicyToboggan.(policies)
    passwords = ["abcde", "cdefg", "ccccccccc","gdgtnfggq"]

    @test AdventOfCode.validate_password.(zip(policies_sled, passwords)) == [true, false, true, true]
    @test AdventOfCode.validate_password.(zip(policies_toboggan, passwords)) == [true, false, false, false]
    @test day02() == (607, 321)
end

@testset "day03" begin
    map = """
          ..##.......
          #...#...#..
          .#....#..#.
          ..#.#...#.#
          .#...##..#.
          ..#.##.....
          .#.#.#....#
          .#........#
          #.##...#...
          #...##....#
          .#..#...#.#"""
    multiple_slopes = 1
    for args  in [(1, 1), (3, 1), (5, 1), (7, 1), (1, 2)]
        multiple_slopes *= AdventOfCode.count_trees(IOBuffer(map), args...)
    end

    @test AdventOfCode.count_trees(IOBuffer(map), 3, 1) == 7
    @test multiple_slopes == 336
    @test day03() == (274, 6050183040)
end
