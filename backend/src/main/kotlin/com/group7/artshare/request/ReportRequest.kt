package com.group7.artshare.request

import lombok.Data


@Data
class ReportRequest (val artItemId: Long, val description: String)