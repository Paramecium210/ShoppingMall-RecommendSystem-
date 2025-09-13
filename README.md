# ShoppingMall-RecommendSystem-
## Introduction
This is a virtual shopping recommend system based on the collaborative filtering algorithm.By calculating the cosine similarity to analysis user relevance, recommendation can be made accordingly.
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
``` List<Collect> allCollect =  collectMapper.selectAll(null);
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
