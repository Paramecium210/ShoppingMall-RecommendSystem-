package com.example.utils;

import cn.hutool.core.collection.CollectionUtil;
import com.example.entity.RelateDTO;

import java.util.*;
import java.util.stream.Collectors;

/**
 * 基于用户的协同过滤推荐算法实现
 * User-based Collaborative Filtering
 */
public class UserCF {

    /**
     * 方法描述：推荐商品id列表
     *
     * @param userId 当前用户
     * @param list   用户商品评分数据
     * @return {@link List<Integer>} 推荐的商品ID列表
     */
    public static List<Integer> recommend(Integer userId, List<RelateDTO> list) {
        // 按用户分组
        Map<Integer, List<RelateDTO>> userMap = list.stream()
                .collect(Collectors.groupingBy(RelateDTO::getUserId));

        // 计算用户相似度（使用余弦相似度）
        Map<Integer, Double> userDisMap = CoreMath.computeNeighbor(userId, userMap, 0);

        if (CollectionUtil.isEmpty(userDisMap)) {
            return Collections.emptyList();
        }

        // 获取关系最近的用户
        double maxValue = Collections.max(userDisMap.values());
        Set<Integer> userIds = userDisMap.entrySet().stream()
                .filter(e -> e.getValue() == maxValue)
                .map(Map.Entry::getKey)
                .collect(Collectors.toSet());

        // 取关系最近的用户
        Integer nearestUserId = userIds.stream().findAny().orElse(null);
        if (nearestUserId == null) {
            return Collections.emptyList();
        }

        // 最近邻用户看过商品列表
        List<Integer> neighborItems = userMap.get(nearestUserId).stream()
                .map(RelateDTO::getGoodsId)
                .collect(Collectors.toList());

        // 指定用户看过商品列表
        List<Integer> userItems = userMap.get(userId).stream()
                .map(RelateDTO::getGoodsId)
                .collect(Collectors.toList());

        // 找到最邻看过，但是该用户没看过的商品
        neighborItems.removeAll(userItems);

        return neighborItems;
    }


}