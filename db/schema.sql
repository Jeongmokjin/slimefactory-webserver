-- =====================================================
-- 슬라임 팩토리 (Slime Factory) — 스키마
-- 팀 나무목 (정목진·김나윤) / MySQL
-- 탈퇴 정책: Soft delete (user.deleted_at)
-- 실행: mysql -uroot -p slimedb < db/schema.sql
-- =====================================================

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `order_item`;
DROP TABLE IF EXISTS `order`;
DROP TABLE IF EXISTS `cart`;
DROP TABLE IF EXISTS `product`;
DROP TABLE IF EXISTS `user`;

-- 1. user — 회원
CREATE TABLE `user` (
    `user_id`    VARCHAR(100)            NOT NULL,
    `name`       VARCHAR(20)             NOT NULL,
    `password`   VARCHAR(255)            NOT NULL,
    `email`      VARCHAR(100)            NOT NULL,
    `phone`      VARCHAR(50)             NOT NULL,
    `role`       ENUM('USER', 'ADMIN')   NOT NULL DEFAULT 'USER',
    `created_at` DATETIME                NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `deleted_at` DATETIME                NULL,
    PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. product — 상품
CREATE TABLE `product` (
    `product_id` BIGINT          NOT NULL AUTO_INCREMENT,
    `name`       VARCHAR(50)     NOT NULL,
    `price`      INT             NOT NULL,
    `description` TEXT           NULL,
    `stock`      INT             NOT NULL DEFAULT 0,
    `image_url`  VARCHAR(1000)   NULL,
    `created_at` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. cart — 장바구니
CREATE TABLE `cart` (
    `cart_id`    BIGINT          NOT NULL AUTO_INCREMENT,
    `user_id`    VARCHAR(100)    NOT NULL,
    `product_id` BIGINT          NOT NULL,
    `quantity`   INT             NOT NULL DEFAULT 1,
    `created_at` DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`cart_id`),
    UNIQUE KEY `UQ_cart_user_product` (`user_id`, `product_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. order — 주문(헤더)  (order 는 예약어 → 백틱)
CREATE TABLE `order` (
    `order_id`    BIGINT                                NOT NULL AUTO_INCREMENT,
    `user_id`     VARCHAR(100)                          NOT NULL,
    `status`      ENUM('ORDERED', 'SHIPPED', 'DONE')    NOT NULL DEFAULT 'ORDERED',
    `total_price` INT                                   NOT NULL,
    `address`     VARCHAR(1000)                         NOT NULL,
    `order_date`  DATETIME                              NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. order_item — 주문 상세
CREATE TABLE `order_item` (
    `order_item_id` BIGINT  NOT NULL AUTO_INCREMENT,
    `order_id`      BIGINT  NOT NULL,
    `product_id`    BIGINT  NOT NULL,
    `quantity`      INT     NOT NULL,
    `price`         INT     NOT NULL COMMENT '주문 시점 가격 스냅샷',
    PRIMARY KEY (`order_item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 외래키 (FK)
ALTER TABLE `cart` ADD CONSTRAINT `FK_cart_user`
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`)
    ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE `cart` ADD CONSTRAINT `FK_cart_product`
    FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`)
    ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `order` ADD CONSTRAINT `FK_order_user`
    FOREIGN KEY (`user_id`) REFERENCES `user`(`user_id`)
    ON DELETE RESTRICT ON UPDATE CASCADE;
ALTER TABLE `order_item` ADD CONSTRAINT `FK_orderitem_order`
    FOREIGN KEY (`order_id`) REFERENCES `order`(`order_id`)
    ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `order_item` ADD CONSTRAINT `FK_orderitem_product`
    FOREIGN KEY (`product_id`) REFERENCES `product`(`product_id`)
    ON DELETE RESTRICT ON UPDATE CASCADE;

SET FOREIGN_KEY_CHECKS = 1;
