import request from '@/utils/request'

export function getSponsorList(params) {
    return request({
        url: '/system/sponsor/list',
        method: 'get',
        params
    })
}
export function getSponsorInfo(id) {
    return request({
        url: '/system/sponsor/info',
        method: 'get',
        params: {
            id: id
        }
    })
}
export function deleteSponsor(data) {
    return request({
        url: '/system/sponsor/delete',
        method: 'delete',
        data
    })
}
export function updateSponsor(data) {
    return request({
        url: '/system/sponsor/update',
        method: 'put',
        data
    })
}
