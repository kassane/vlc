// Requires: zig master (0.11-dev build 1550)
// based on: https://github.com/andrewrk/nasm/blob/master/build.zig

const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "vlc",
        .target = target,
        .optimize = optimize,
    });
    const t = exe.target_info.target;
    exe.addIncludePath("include");
	exe.addIncludePath("src");
	exe.addIncludePath("src/config");
	exe.addIncludePath("src/playlist");
	exe.addIncludePath("src/player");
	exe.addIncludePath("src/input");
	exe.addIncludePath("src/text");
    exe.addIncludePath("src/video_output");
//	exe.addConfigHeader(b.addConfigHeader(.{
//        .style = .blank,
//        .include_path = "version.h",
//    }, .{
//        .NASM_MAJOR_VER = 2,
//        .NASM_MINOR_VER = 16,
//        .NASM_SUBMINOR_VER = 1,
//        .NASM_PATCHLEVEL_VER = 0,
//        .NASM_VERSION_ID = 0x02100100,
//        .NASM_VER = "2.16.01",
//    }));
//    exe.addConfigHeader(b.addConfigHeader(.{
//        .style = .{ .autoconf = .{ .path = "config/config.h.in" } },
//        .include_path = "config/config.h",
//    }, .{
//        .ABORT_ON_PANIC = have(optimize == .Debug),
//        .restrict = .restrict,
//        .size_t = null,
//        .snprintf = null,
//        .typeof = .__typeof,
//        .uintptr_t = null,
//        .vsnprintf = null,
//    }));
    exe.addCSourceFiles(&.{
        "src/libvlc.c",
		"src/libvlc-module.c",
		"src/missing.c",
		"src/version.c",

		"src/config/core.c",
		"src/config/chain.c",
		"src/config/file.c",
		"src/config/help.c",
		"src/config/intf.c",
		"src/config/cmdline.c",
		"src/config/getopt.c",

		"src/config/jaro_winkler.c",
		"src/extras/libc.c",
		"src/media_source/media_source.c",
		"src/media_source/media_tree.c",
	
		"src/modules/modules.c",
		"src/modules/bank.c",
		"src/modules/cache.c",
		"src/modules/entry.c",
		"src/modules/textdomain.c",
	
		"src/interface/dialog.c",
		"src/interface/interface.c",
	
		"src/playlist/content.c",
		"src/playlist/control.c",
		"src/playlist/export.c",
		"src/playlist/item.c",
		"src/playlist/notify.c",
		"src/playlist/notify.h",
		"src/playlist/player.c",
		"src/playlist/playlist.c",
		"src/playlist/preparse.c",
		"src/playlist/randomizer.c",
		"src/playlist/request.c",
		"src/playlist/shuffle.c",
		"src/playlist/sort.c",
		"src/preparser/art.c",
		"src/preparser/fetcher.c",
		"src/preparser/preparser.c",
		"src/input/item.c",
		"src/input/access.c",
		"src/clock/clock_internal.c",
		"src/clock/input_clock.c",
		"src/clock/clock.c",
		"src/input/decoder.c",
		"src/input/decoder_device.c",
		"src/input/decoder_helpers.c",
		"src/input/demux.c",
		"src/input/demux_chained.c",
		"src/input/es_out.c",
		"src/input/es_out_source.c",
		"src/input/es_out_timeshift.c",
		"src/input/input.c",
		"src/input/meta.c",
		"src/input/attachment.c",
		"src/player/player.c",
		"src/player/input.c",
		"src/player/timer.c",
		"src/player/track.c",
		"src/player/title.c",
		"src/player/aout.c",
		"src/player/vout.c",
		"src/player/osd.c",
		"src/player/medialib.c",
		"src/player/metadata.c",

		"src/input/resource.c",
		"src/input/services_discovery.c",
		"src/input/stats.c",
		"src/input/stream.c",
		"src/input/stream_fifo.c",
		"src/input/stream_extractor.c",
		"src/input/stream_filter.c",
		"src/input/stream_memory.c",
		"src/input/subtitles.c",
		"src/input/thumbnailer.c",
		"src/input/var.c",

		"src/audio_output/common.c",
		"src/audio_output/dec.c",
		"src/audio_output/filters.c",
		"src/audio_output/meter.c",
		"src/audio_output/output.c",
		"src/audio_output/volume.c",
		
		"src/video_output/control.c",
		"src/video_output/display.c",
		"src/video_output/inhibit.c",
		"src/video_output/interlacing.c",
		"src/video_output/snapshot.c",
		"src/video_output/video_output.c",
		"src/video_output/video_text.c",
		"src/video_output/video_epg.c",
		"src/video_output/video_widgets.c",
		"src/video_output/vout_subpictures.c",
		"src/video_output/video_window.c",
		"src/video_output/opengl.c",
		"src/video_output/vout_intf.c",
		"src/video_output/vout_wrapper.c",
		"src/video_output/window.c",
		
		"src/network/getaddrinfo.c",
		"src/network/http_auth.c",
		"src/network/httpd.c",
		"src/network/io.c",
		"src/network/tcp.c",
		"src/network/udp.c",
		"src/network/rootbind.c",
		"src/network/stream.c",
		"src/network/tls.c",
		
		"src/text/charset.c",
		"src/text/memstream.c",
		"src/text/strings.c",
		"src/text/unicode.c",
		"src/text/url.c",
		"src/text/filesystem.c",
		"src/text/iso_lang.c",
		
		"src/misc/actions.c",
		"src/misc/ancillary.c",
		"src/misc/executor.c",
		"src/misc/md5.c",
		"src/misc/probe.c",
		"src/misc/rand.c",
		"src/misc/mtime.c",
		"src/misc/frame.c",
		"src/misc/fifo.c",
		"src/misc/fourcc.c",
		"src/misc/es_format.c",
		"src/misc/picture.c",
		"src/misc/picture_fifo.c",
		"src/misc/picture_pool.c",
		"src/misc/interrupt.c",
		"src/misc/keystore.c",
		"src/misc/renderer_discovery.c",
		"src/misc/threads.c",
		"src/misc/cpu.c",
		"src/misc/diffutil.c",
		"src/misc/epg.c",
		"src/misc/exit.c",
		"src/misc/events.c",
		"src/misc/image.c",
		"src/misc/messages.c",
		"src/misc/mime.c",
		"src/misc/objects.c",
		"src/misc/objres.c",
		"src/misc/queue.c",
		"src/misc/variables.c",
		"src/misc/xml.c",
		"src/misc/addons.c",
		"src/misc/filter.c",
		"src/misc/filter_chain.c",
		"src/misc/httpcookies.c",
		"src/misc/fingerprinter.c",
		"src/misc/text_style.c",
		"src/misc/sort.c",
		"src/misc/subpicture.c",
		"src/misc/medialibrary.c",
		"src/misc/viewpoint.c",
		"src/misc/rcu.c",
		"src/misc/tracer.c",
    }, &.{
        "-DHAVE_CONFIG_H",
        "-std=c17",
    });
    exe.linkLibC();
    exe.install();
}

fn have(c: bool) ?c_int {
    return if (c) 1 else null;
}
