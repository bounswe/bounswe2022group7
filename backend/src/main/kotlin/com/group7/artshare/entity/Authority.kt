package com.group7.artshare.entity

import lombok.Getter
import lombok.Setter
import org.springframework.security.core.GrantedAuthority
import javax.persistence.*


@Entity
@Getter
@Setter
class Authority(
    private val authority: String
) : GrantedAuthority {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private val id: Long? = null

    @ManyToMany(mappedBy = "authorities") private val users: Set<RegisteredUser> = HashSet()
    override fun getAuthority(): String {
        return authority
    }
}