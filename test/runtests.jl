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

@testset "day04" begin
    mixed = """
            ecl:gry pid:860033327 eyr:2020 hcl:#fffffd
            byr:1937 iyr:2017 cid:147 hgt:183cm

            iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884
            hcl:#cfa07d byr:1929

            hcl:#ae17e1 iyr:2013
            eyr:2024
            ecl:brn pid:760753108 byr:1931
            hgt:179cm

            hcl:#cfa07d eyr:2025 pid:166559648
            iyr:2011 ecl:brn hgt:59in"""
    valid = """
            pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
            hcl:#623a2f

            eyr:2029 ecl:blu cid:129 byr:1989
            iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

            hcl:#888785
            hgt:164cm byr:2001 iyr:2015 cid:88
            pid:545766238 ecl:hzl
            eyr:2022

            iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719"""
    invalid = """
              eyr:1972 cid:100
              hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

              iyr:2019
              hcl:#602927 eyr:1967 hgt:170cm
              ecl:grn pid:012533040 byr:1946

              hcl:dab227 iyr:2012
              ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

              hgt:59cm ecl:zzz
              eyr:2038 hcl:74454a iyr:2023
              pid:3556412378 byr:2007"""
    @test AdventOfCode.validate_passport_keys.(AdventOfCode.parse_passport(IOBuffer(mixed))) == [true, false, true, false]
    @test AdventOfCode.validate_passport_values.(AdventOfCode.parse_passport(IOBuffer(valid))) == [true, true, true, true]
    @test AdventOfCode.validate_passport_values.(AdventOfCode.parse_passport(IOBuffer(invalid))) == [false, false, false, false]
    @test day04() == (206, 123)
end

@testset "day05" begin
    boardingpass = ["BFFFBBFRRR", "FFFBBBFRRR", "BBFFBBFRLL"]
    @test AdventOfCode.decode_row("FBFBBFF") == 44
    @test AdventOfCode.decode_column("RLR") == 5
    @test AdventOfCode.seat_id.(boardingpass) == [567, 119, 820]
    @test day05() == (880, 731)
end

@testset "day06" begin
    groups =  ["abc", "a\nb\nc", "ab\nac", "a\na\na\na", "b"]
    @test AdventOfCode.any_yes.(groups) == [3, 3, 3, 1, 1]
    @test AdventOfCode.every_yes.(groups) == [3, 0, 1, 1, 1]
    @test day06() == (7027, 3579)
end

@testset "day07" begin
    rules = """
            light red bags contain 1 bright white bag, 2 muted yellow bags.
            dark orange bags contain 3 bright white bags, 4 muted yellow bags.
            bright white bags contain 1 shiny gold bag.
            muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
            shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
            dark olive bags contain 3 faded blue bags, 4 dotted black bags.
            vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
            faded blue bags contain no other bags.
            dotted black bags contain no other bags."""
    bags = AdventOfCode.rules(IOBuffer(rules))
    @test length(bags) == 9
    @test AdventOfCode.shiny_gold("dark orange", bags) == true
    @test AdventOfCode.count_shiny_gold(bags) == 4
end

@testset "day08" begin
    boot = """
           nop +0
           acc +1
           jmp +4
           acc +3
           jmp -3
           acc -99
           acc +1
           jmp -4
           acc +6"""
    @test AdventOfCode.accumulator(AdventOfCode.parse_bootcode(IOBuffer(boot))) == (5, false)
    @test AdventOfCode.repair(AdventOfCode.parse_bootcode(IOBuffer(boot))) == 8
    @test AdventOfCode.day08() == (1675, 1532)
end
