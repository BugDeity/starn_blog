import request from '@/utils/request'

export function getNote(params) {
    return request({
        url: '/v1/note/',
        method: 'get',
        params: params
    })
}
export function insertNote(data) {
    return request({
        url: '/v1/note/',
        method: 'post',
        data
    })
}
export function selectNoteByUserId(params) {
    return request({
        url: '/v1/note/selectNoteByUserId',
        method: 'get',
        params: params
    })
}
export function deleteNote(id) {
    return request({
        url: '/v1/note/delete',
        method: 'delete',
        params: {
            id: id
        }
    })
}