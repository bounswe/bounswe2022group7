package com.group7.artshare.repository

import com.group7.artshare.entity.Auction
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository


@Repository
interface AuctionRepository : JpaRepository<Auction, Long> {
}