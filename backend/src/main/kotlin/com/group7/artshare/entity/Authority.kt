package com.group7.artshare.entity

import lombok.Getter
import lombok.Setter
import org.springframework.security.core.GrantedAuthority
import javax.persistence.*


@Entity
@Getter
@Setter
class Authority(
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY) private val id: Long? = null,
    private val authority: String? = null,

    @ManyToMany(mappedBy = "authorities") private val users: Set<CustomUser>? = null
) : GrantedAuthority {
    override fun getAuthority(): String? {
        return authority
    }
}