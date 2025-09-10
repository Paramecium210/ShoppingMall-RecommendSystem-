package com.example.utils;

import com.example.entity.RelateDTO;

import java.util.*;

/**
 * 数学计算工具类
 */
public class CoreMath {

    /**
     * 计算指定用户与其他用户的相似度（余弦相似度）
     *
     * @param userId  指定用户
     * @param userMap 用户 -> [评分数据] 的映射
     * @param type    预留参数（0: 余弦相似度）
     * @return 其他用户的相似度 Map<用户ID, 相似度>
     */
    public static Map<Integer, Double> computeNeighbor(Integer userId, Map<Integer, List<RelateDTO>> userMap, int type) {
        Map<Integer, Double> result = new HashMap<>();

        List<RelateDTO> userRatings = userMap.get(userId);
        if (userRatings == null || userRatings.isEmpty()) {
            return result;
        }

        // 当前用户的 {商品 -> index} 映射
        Map<Integer, Double> userItemScore = new HashMap<>();
        for (RelateDTO r : userRatings) {
            userItemScore.put(r.getGoodsId(), r.getIndex().doubleValue());
        }

        // 遍历其他用户
        for (Map.Entry<Integer, List<RelateDTO>> entry : userMap.entrySet()) {
            Integer otherUserId = entry.getKey();
            if (Objects.equals(userId, otherUserId)) {
                continue; // 跳过自己
            }

            Map<Integer, Double> otherItemScore = new HashMap<>();
            for (RelateDTO r : entry.getValue()) {
                otherItemScore.put(r.getGoodsId(), r.getIndex().doubleValue());
            }

            // 计算余弦相似度
            double sim = cosineSimilarity(userItemScore, otherItemScore);
            result.put(otherUserId, sim);
        }

        return result;
    }

    /**
     * 余弦相似度计算
     *
     * @param user1Scores 商品->评分
     * @param user2Scores 商品->评分
     * @return 相似度
     */
    private static double cosineSimilarity(Map<Integer, Double> user1Scores,
                                           Map<Integer, Double> user2Scores) {
        // 计算点积
        double dotProduct = 0.0;
        for (Integer itemId : user1Scores.keySet()) {
            if (user2Scores.containsKey(itemId)) {
                dotProduct += user1Scores.get(itemId) * user2Scores.get(itemId);
            }
        }

        // 计算向量长度
        double normA = Math.sqrt(user1Scores.values().stream()
                .mapToDouble(v -> v * v).sum());
        double normB = Math.sqrt(user2Scores.values().stream()
                .mapToDouble(v -> v * v).sum());

        if (normA == 0 || normB == 0) {
            return 0.0;
        }

        return dotProduct / (normA * normB);
    }
}
