using AdventOfCode, Test

@testset "day01" begin
    seq = [1721, 979, 366, 299, 675, 1456]
    @test AdventOfCode.find_two_entries(seq) == 1721 * 299
    @test AdventOfCode.find_three_entries(seq) == 979 * 366 * 675
    @test day01() == (1010299, 42140160)
end
