package com.example.service;

import cn.hutool.core.collection.CollectionUtil;
import com.example.common.enums.RoleEnum;
import com.example.entity.*;
import com.example.mapper.*;
import com.example.utils.TokenUtils;
import com.example.utils.UserCF;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * 分类信息表业务处理
 **/
@Service
public class GoodsService {

    @Resource
    private GoodsMapper goodsMapper;
    @Resource
    private CollectMapper collectMapper;
    @Resource
    private CartMapper cartMapper;
    @Resource
    private OrdersMapper ordersMapper;
    @Resource
    private CommentMapper commentMapper;
    @Resource
    private UserMapper userMapper;

    /**
     * 新增
     */
    public void add(Goods goods) {

        Account currentUser = TokenUtils.getCurrentUser();
        if(RoleEnum.BUSINESS.name().equals(currentUser.getRole())){
            goods.setBusinessId(currentUser.getId());
        }
        goods.setCount(0);
        goodsMapper.insert(goods);
    }

    /**
     * 删除
     */
    public void deleteById(Integer id) {
        goodsMapper.deleteById(id);
    }

    /**
     * 批量删除
     */
    public void deleteBatch(List<Integer> ids) {
        for (Integer id : ids) {
            goodsMapper.deleteById(id);
        }
    }

    /**
     * 修改
     */
    public void updateById(Goods goods) {
        goodsMapper.updateById(goods);
    }

    /**
     * 根据ID查询
     */
    public Goods selectById(Integer id) {
        return goodsMapper.selectById(id);
    }

    /**
     * 查询所有
     */
    public List<Goods> selectAll(Goods goods) {
        return goodsMapper.selectAll(goods);
    }

    /**
     * 分页查询
     */
    public PageInfo<Goods> selectPage(Goods goods, Integer pageNum, Integer pageSize) {
        Account currentUser = TokenUtils.getCurrentUser();
        if (RoleEnum.BUSINESS.name().equals(currentUser.getRole())){
            goods.setBusinessId(currentUser.getId());
        }
        PageHelper.startPage(pageNum, pageSize);
        List<Goods> list = goodsMapper.selectAll(goods);
        return PageInfo.of(list);
    }

    public List<Goods> selectTop15(){
        return goodsMapper.selectTop15();
    }

    public List<Goods> selectByTypeId(Integer id) {
        return goodsMapper.selectByTypeId(id);
    }


    public List<Goods> selectByName(String name) {
        return goodsMapper.selectByName(name);
    }

    public List<Goods> recommend() {
        // 1) 准备数据
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

        // 2) 算法给出的商品ID
        List<Integer> goodsIds = UserCF.recommend(currentUser.getId(), data);

        // 做一个 map 方便 O(1) 查找
        java.util.Map<Integer, Goods> goodsMap = allGoods.stream()
                .collect(Collectors.toMap(Goods::getId, g -> g, (a, b) -> a));

        // 3) 把推荐 ID 转商品，去重、过滤 null
        List<Goods> recommendResult = goodsIds.stream()
                .distinct()
                .map(goodsMap::get)
                .filter(java.util.Objects::nonNull)
                .collect(Collectors.toCollection(ArrayList::new));

        // 4) 兜底：算法没有产出 -> 随机 15 个
        if (CollectionUtil.isEmpty(recommendResult)) {
            return goodsMapper.selectTop15();
        }

        // 6) 超过 10 个 -> 截断前 10
        if (recommendResult.size() > 10) {
            recommendResult = recommendResult.subList(0, 10);
        }

        return recommendResult;
    }

}