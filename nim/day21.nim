import strutils, sets, algorithm, tables, sugar


type
  Allergen = string
  Ingredient = string
  Ingredients = HashSet[Ingredient]
  IngredientCount = CountTable[Ingredient]
  PossibleAlergens = OrderedTable[Allergen, Ingredients]
  Allergens = OrderedTable[Allergen, Ingredient]


proc parse(path: string): (PossibleAlergens, IngredientCount) =
  for line in path.lines:
    let parts = line.split(" (contains ")
    let ingredients = parts[0].split
    for allergen in parts[1][0..^2].split(", "):
      if not result[0].hasKey(allergen):
        result[0][allergen] = ingredients.toHashSet
      else:
        result[0][allergen] = result[0][allergen] * ingredients.toHashSet
    result[1].merge ingredients.toCountTable

func eliminateImpossible(ingredientTable: PossibleAlergens): Allergens =
  var seen: Ingredients
  while seen.card != ingredientTable.len:
    for allergen, ingredients in ingredientTable.pairs:
      var remaining = ingredients - seen
      if remaining.card == 1:
        let ingredient = remaining.pop
        seen.incl ingredient
        result[allergen] = ingredient
  result.sort(cmp)

func countSafe(allIngredients: IngredientCount, dangerous: seq[Ingredient]): int =
  for a, count in allIngredients.pairs:
    if a notin dangerous:
      result += count

let (possibleAllergens, allIngredients) = parse "inputs/21.txt"
let allergens = eliminateImpossible possibleAllergens
let dangerous = collect(for v in allergens.values: v)

echo allIngredients.countSafe(dangerous)
echo dangerous.join(",")
