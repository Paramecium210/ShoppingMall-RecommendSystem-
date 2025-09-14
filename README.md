# ShoppingMall-RecommendSystem-
## Introduction
This is a virtual shopping recommendation system based on collaborative filtering. By analyzing user behavior and calculating cosine similarity to measure user relevance, the system generates personalized product suggestions.
### Tech stack
#### Backend tech
Java, Springboot, MyBatis
#### Frontend tech
Vue，element-UI，HTML，CSS，JavaScript
#### Database
MySQL，Navicat
#### IDE
IDEA
### Project environment
jdk8，MySQL5.7，IDEA，Navicat，Node14
## Collaborative filtering
The system represents user preferences as vectors and computes the cosine similarity between them. A higher similarity score indicates stronger relevance, which is used to generate tailored product recommendations.
### Details
In the recommend method of GoodsService, user interactions are assigned different weights to reflect their engagement level:
Favorite: 1
Add to Cart: 2
Order: 3
Comment: 2
Only interactions with a weight greater than 1 are included in the RelateDTO, ensuring that stronger signals contribute to the recommendation logic.
GoodsService.recommend():
```java
List<Collect> allCollect =  collectMapper.selectAll(null);
        List<Cart> allCart = cartMapper.selectAll(null);
        List<Orders> allOrders = ordersMapper.selectAllOrders(null);
        List<Comment> allComment = commentMapper.selectAll(null);
        List<User> allUsers = userMapper.selectAll(null);
        List<Goods> allGoods = goodsMapper.selectAll(null);

        List<RelateDTO> data = new ArrayList<>();

        for (Goods goods : allGoods) {
            Integer goodsId = goods.getId();
            for (User user : allUsers) {
                Integer userId = user.getId();
                int index = 1;
                if (allCollect.stream().anyMatch(x -> x.getGoodsId().equals(goodsId) && x.getUserId().equals(userId))) {
                    index += 1;
                }
                if (allCart.stream().anyMatch(x -> x.getGoodsId().equals(goodsId) && x.getUserId().equals(userId))) {
                    index += 2;
                }
                if (allOrders.stream().anyMatch(x -> x.getGoodsId().equals(goodsId) && x.getUserId().equals(userId))) {
                    index += 3;
                }
                if (allComment.stream().anyMatch(x -> x.getGoodsId().equals(goodsId) && x.getUserId().equals(userId))) {
                    index += 2;
                }
                if (index > 1) {
                    data.add(new RelateDTO(userId, goodsId, index));
                }
            }
        }
Account currentUser = TokenUtils.getCurrentUser();

        // The algorithm returns a list of recommended product IDs based on user similarity and interaction weights.
        List<Integer> goodsIds = UserCF.recommend(currentUser.getId(), data);

        // Create a map for O(1) lookup efficiency by using product IDs as keys.
        java.util.Map<Integer, Goods> goodsMap = allGoods.stream()
                .collect(Collectors.toMap(Goods::getId, g -> g, (a, b) -> a));

        // Convert recommended product IDs into product objects, remove duplicates, and filter out null values.
        List<Goods> recommendResult = goodsIds.stream()
                .distinct()
                .map(goodsMap::get)
                .filter(java.util.Objects::nonNull)
                .collect(Collectors.toCollection(ArrayList::new));

        return recommendResult;
```


In the recommend method, the system uses a UserCF (User-based Collaborative Filtering) approach.
First, users are grouped by their IDs.
Then, cosine similarity is used to calculate the relevance between users.
The system identifies the most similar users and selects products from their interaction history.
Products that the current user hasn't viewed are returned as neighborItems.
```java
Map<Integer, List<RelateDTO>> userMap = list.stream()
                .collect(Collectors.groupingBy(RelateDTO::getUserId));

       // Calculate user similarity using cosine similarity
        Map<Integer, Double> userDisMap = CoreMath.computeNeighbor(userId, userMap, 0);

        if (CollectionUtil.isEmpty(userDisMap)) {
            return Collections.emptyList();
        }

        // Get the most similar users
        double maxValue = Collections.max(userDisMap.values());
        Set<Integer> userIds = userDisMap.entrySet().stream()
                .filter(e -> e.getValue() == maxValue)
                .map(Map.Entry::getKey)
                .collect(Collectors.toSet());

        // Select the most similar users
        Integer nearestUserId = userIds.stream().findAny().orElse(null);
        if (nearestUserId == null) {
            return Collections.emptyList();
        }

       // Items viewed by nearest neighbor users
        List<Integer> neighborItems = userMap.get(nearestUserId).stream()
                .map(RelateDTO::getGoodsId)
                .collect(Collectors.toList());

        // Items viewed by the target user
        List<Integer> userItems = userMap.get(userId).stream()
                .map(RelateDTO::getGoodsId)
                .collect(Collectors.toList());

        // Find items viewed by neighbors but not by the target user
        neighborItems.removeAll(userItems);

        return neighborItems;
```
The CoreMath file implements the cosine similarity formula used to measure user similarity. The formula is as follows:

$similarity(A, B) = \frac{A \cdot B}{\|A\| \times \|B\|}$

where 𝐴 and 𝐵 are user interaction vectors. A higher score indicates stronger similarity between users.
```java
public static Map<Integer, Double> computeNeighbor(Integer userId, Map<Integer, List<RelateDTO>> userMap, int type) {
        Map<Integer, Double> result = new HashMap<>();

        List<RelateDTO> userRatings = userMap.get(userId);
        if (userRatings == null || userRatings.isEmpty()) {
            return result;
        }

        // Mapping of {product -> index} for the current user
        Map<Integer, Double> userItemScore = new HashMap<>();
        for (RelateDTO r : userRatings) {
            userItemScore.put(r.getGoodsId(), r.getIndex().doubleValue());
        }

        // Iterate over other users
        for (Map.Entry<Integer, List<RelateDTO>> entry : userMap.entrySet()) {
            Integer otherUserId = entry.getKey();
            if (Objects.equals(userId, otherUserId)) {
                continue; // Skip the current user

            }

            Map<Integer, Double> otherItemScore = new HashMap<>();
            for (RelateDTO r : entry.getValue()) {
                otherItemScore.put(r.getGoodsId(), r.getIndex().doubleValue());
            }

           // Calculate cosine similarity
            double sim = cosineSimilarity(userItemScore, otherItemScore);
            result.put(otherUserId, sim);
        }

        return result;
    }

  
    private static double cosineSimilarity(Map<Integer, Double> user1Scores,
                                           Map<Integer, Double> user2Scores) {
        // Calculate dot product
        double dotProduct = 0.0;
        for (Integer itemId : user1Scores.keySet()) {
            if (user2Scores.containsKey(itemId)) {
                dotProduct += user1Scores.get(itemId) * user2Scores.get(itemId);
            }
        }

        // Calculate vector magnitude
        double normA = Math.sqrt(user1Scores.values().stream()
                .mapToDouble(v -> v * v).sum());
        double normB = Math.sqrt(user2Scores.values().stream()
                .mapToDouble(v -> v * v).sum());

        if (normA == 0 || normB == 0) {
            return 0.0;
        }

        return dotProduct / (normA * normB);
    }
```
## Execution Screenshot
Login
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/225c4946-58ca-45e6-a651-beac966e7786" />
Home
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/16e9f941-51cb-4444-af3a-d9366b2ac105" />
Recommend Items
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c7f0cf2f-d3d8-4ba9-af40-c8f5d322e82c" />
You can see the details of the UserCF and the GoodsService


