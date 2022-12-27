package com.group7.artshare.repository

import com.group7.artshare.entity.Report
import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository

@Repository
interface ReportRepository : JpaRepository<Report, Long>